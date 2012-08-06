set bg=dark	
set lines=45
set columns=120
set guifont=Monaco:h12
set fuoptions=maxvert,maxhorz
set guioptions-=rL

if has("gui_macvim")
  macmenu &File.New\ Tab key=
  map  :CommandT
endif

