" Change fix_header.py path to where ever ssh://git@bitbucket.sdl.usu.edu:7999/airwolf/ocr-prepper.git is cloned
!python3 ~/projects/ocr_prepper/fix_header.py %
e!
silent! g/^$/d
silent! 19,$s/ *| */|/g
silent! 21,s/0|NA/0||NA/
silent! 19,$s/\d|\zs\ze|enum/|/
silent! 19,$s/enum: \w\+\d\+\zs\ze|\d/|/
20
norm 0
for i in range(8) | execute "norm! kf|jhdt|i-l" | endfor
