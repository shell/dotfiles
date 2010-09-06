" Vim filetype plugin for using variables in CSS
" Filetype:       .css
" Version:        1.0
" Last Change:    2009 jul 14
" Maintainer:     Benno van Keulen <bne AT ziggo DOT nl>
" Python:         2.5.2

" License:        GNU GPL
" Copyright (C) 2009 Benno van Keulen
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" any later version.
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
" GNU General Public License for more details.
" You should have received a copy of the GNU General Public License
" along with this program. If not, see <http://www.gnu.org/licenses/>


" INSTALLATION
" Put this file in your file type plugin directory ~/.vim/ftplugin.
" Change the defaults in this file to your liking (jump to line 54).

" To invoke the plugin:
" :call CSSvar()

" You can put a mapping in your .vimrc to call the plugin like this:
" nmap <F5> <Plug>CSSvar
" imap <F5> <C-O><Plug>CSSvar

" don't load twice
if exists("b:loaded_cssvar")
    finish
endif
let b:loaded_cssvar = 1

" Mappings
nnoremap <buffer> <unique> <Plug>CSSvar :call CSSvar()<CR>
inoremap <buffer> <unique> <Plug>CSSvar :call CSSvar()<CR>

" make sure the function is defined only once
if !exists("*s:CSSvar")
function! CSSvar()
python << EOF
import re
import os
import vim
vimbuffer = vim.current.buffer

###################################################################
# Global variables with default values which can be overridden here
filenameseparator = '-'   # start of the filename suffix
starttag = '['
endtag = ']'
errorstring = '???'
commstr = '!!'  # start of the user command string
###################################################################

# Main Python functions are:
# - cssvarline (string): return a processed line
# - cssvarbuff (list): return a processed list
# - parse_buffer_write_cssfile (): process vim buffer and 
#   write a processed list to a css file

# --- Globals ---
vardict = {} # variables dictionary 


# --- SUBFUNCTIONS - functions used in other functions ---

def stripspace (instring):
    """remove spaces from a string"""
    uitstring = re.sub(' ', '', instring)
    return uitstring

def hascsscolor (instring):
    """check for css color strings inside a string"""
    checkcolor = False
    if '#' in instring:
        checkcolor = True
    if 'rgb' in instring:
        checkcolor = True
    return checkcolor

def hasnowrongchars (instring):  # subfunction of evalstring
    """check if characters are allowed in calculations"""
    nowrongchars = True
    for item in instring:
        if item not in '0123456789-+.%()/* ':
            nowrongchars = False
    return nowrongchars

def split2explist (instring):
    """split a string into a list seperating variables from symbols"""
    outlist = []
    currentmathflag = 0
    prevmathflag = 3
    word = ''
    mathsymbols = '+-/*()%'
    for count in range(len(instring)):
        char = instring[count]
        if char in mathsymbols:
            currentmathflag = 1
        else:
            currentmathflag = 0
        if count != 0 and currentmathflag != prevmathflag:
            outlist.append(word)
            word = ''
        word = ''.join((word, char))
        prevmathflag = currentmathflag
    # flush last word
    outlist.append(word)
    return outlist

def evalexplist (inlist):
    """replace variables in the list with values from the global variable
    dictionary"""
    outstring = ""
    for count in range(len(inlist)):
        inword = inlist[count]
        nvalue = inword
        firstchar = inword[0]
        if firstchar.isalpha():
            nvalue = findinvardict (inword)
        inlist[count] = nvalue
    # convert list to string
    for item in inlist:
        outstring = ''.join((outstring, str(item)))
    return outstring

def findinvardict (searchkey):
    """search for a variable in the variable dictionary; return value or errorstring"""
    # subfunction of evalexplist
    if searchkey in vardict:
        return vardict[searchkey]
    else:
        return errorstring + searchkey

def makefloats (instring):
    """add .0 to groups of digits to avoid classic division"""
    # used in evalstring
    numbersymbols = "0123456789."
    instring = ''.join((instring, " "))  # to process last digit
    uitstring = ""
    wordcount = 1
    extrastr = ""
    stopflag = 0
    numberflag = 0
    if instring[0] in numbersymbols:
        numberflag = 1
    prevnumberflag = numberflag
    for count in range(len(instring)):
        char = instring[count]
        if char in numbersymbols:
            numberflag = 1
            if char == ".":
                stopflag = 1
        else:
            numberflag = 0
        if numberflag != prevnumberflag:
            wordcount += 1
            if prevnumberflag == 1 and stopflag == 0:
                extrastr = ".0"
            stopflag = 0
        uitstring = ''.join((uitstring, extrastr, char))
        prevnumberflag = numberflag
        extrastr = ""
    # remove last character    
    return uitstring[0:-1]

def evalstring (instring):
    """test and compute an expressionstring, output a string"""
    if hasnowrongchars (instring):
        # , to .
        substring = re.sub(',', '.', instring)
        # 25% to (25/100)
        substring = re.sub('(?P<perc>\d+\.?\d*)%', '(\g<perc>/100.0)', substring)
        codestring = makefloats (substring)
        try:
            sub = eval(codestring)
            outstring = round(sub,2)
            outstring = str(outstring)
        except BaseException, e:
            outstring = ''.join((errorstring, instring))
    else:
        outstring = ''.join((errorstring, instring))
        # remove .0
    outstring = re.sub('\.0(?!\d)', '', outstring) 
    return outstring

def properassignstring (instring):
    check = False
    pattern = '\D+.*\ *=\ *.+'
    m = re.match(pattern, instring)
    if m is not None:
        check = True
    return check


# --- FUNCTIONS TAG-LEVEL ---

def convertvar (instring):
    """parse a string with variables"""
    sublist = []
    if hascsscolor(instring):
        outstring = instring
    else:
        instring = stripspace(instring)
        sublist = split2explist(instring)
        substring = evalexplist(sublist)
        if hascsscolor(substring):
            outstring = substring
        else:
            outstring = evalstring(substring)
    return outstring

def assignvar (instring):
    """assign a value to a variable"""
    sublist = []
    outstring = ''
    if properassignstring (instring):
        # remove spaces
        instring = stripspace(instring)
        # split string with = as separator
        sublist = instring.split('=')
        newkey = sublist[0]
        subvalue = sublist[1]
        newvalue = convertvar(subvalue)
        vardict[newkey] = newvalue
    else:
        outstring = ''.join((errorstring, instring))
    return outstring

def cssvartag (match):
    """main tagparsing function"""
    # match to string
    intag = match.group()
    # remove tags
    intag = intag[1:-1]
    outtag = ''
    if '=' in intag:
        assignvar (intag)
    else:
        outtag = convertvar (intag)
    return outtag

def changedefaults (instring):
    """let the user change the default settings in the development document"""
    instring = ''.join((instring, ' '))  # add space to process last item
    # errorstring
    global errorstring
    pattern = 'er\s*=\s*(.+?)\s' 
    match = re.search(pattern, instring)
    if match is not None:
        errorstring = match.group(1)
    # opentag
    global starttag
    pattern = 'op\s*=\s*(.{1})\s?'
    match = re.search(pattern, instring)
    if match is not None:
        starttag = match.group(1)
    # closetag
    global endtag
    pattern = 'cl\s*=\s*(.{1})\s?'
    match = re.search(pattern, instring)
    if match is not None:
        endtag = match.group(1)
    # commandstring
    global commstr 
    pattern = 'cm\s*=\s*(.+?)\s' 
    match = re.search(pattern, instring)
    if match is not None:
        commstr = match.group(1)
    return


# --- MAIN LINE FUNCTION ---

def cssvarline (inline):
    """Return a string with all tags processed"""
    metachars = '.^$*+?\{}[]()|'
    startescape = ''
    endescape = ''
    if starttag in metachars:
        startescape = '\\'
    if endtag in metachars:
        endescape = '\\'
    pattern = ''.join((startescape, starttag, '.+?', endescape, endtag))
    p = re.compile(pattern)
    outline = p.sub(cssvartag,inline)
    return outline


# --- MAIN BUFFER FUNCTION ---

def cssvarbuff (inlist):
    """Change and return a processed global list"""
    buffout = []
    for item in inlist:
        if starttag in item:
            outline = cssvarline(item)
        elif commstr in item:
            #outline = inline
            outline = ''
            changedefaults(item)
        else:
            outline = item 
        buffout.append(outline)
    return buffout


# --- FILE AND VIMBUFFER FUNCTIONS ---

def writefile (filepath, inlist):
    """write a list to a file"""
    file = open(filepath, 'w')
    if file:
        for item in inlist:
            file.write(''.join((item, os.linesep)))
        file.close()
    else:
        print "error writing file"
    return

def parse_buffer_write_cssfile ():
    """parse current buffer and write a processed css file in the buffer file directory"""
    global vimbuffer
    # get full path and name from the vim buffer file
    bufferpath = vimbuffer.name
    # get directory of buffer file
    dir = os.path.dirname(bufferpath)
    # get filename + extension
    filenamefull = os.path.basename(bufferpath)
    # split filename & extension
    filename = os.path.splitext(filenamefull)
    # remove suffix from filename
    escape = ''
    if filenameseparator in '.^$*+?\{}[]()|':
        escape = '\\'
    pattern = ''.join((escape, filenameseparator, '.*'))
    match = re.subn(pattern, '', filename[0])
    if match[1] is not 0:  # make sure there's a filenameseparator in file name
        name = match[0] + '.css'
        cssfile = os.path.join (dir, name)
        # process vimbuffer
        outlist = cssvarbuff(vimbuffer)
        # write css file
        writefile(cssfile, outlist)
    else:
        print "no suffix in buffer file name"
    return


parse_buffer_write_cssfile()
print "ready"
EOF
endfunction
endif
