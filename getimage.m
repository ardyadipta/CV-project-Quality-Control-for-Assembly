vid = videoinput('macvideo', 2, 'ARGB32_1280x960');
imaqmem(100000000);
start(vid);
%preview(vid);
pics=cell(1,20);
for i=1:20
   pause(1);
   pics{i}=getsnapshot(vid);
end
flushdata(vid)

vid = videoinput('macvideo', 2, 'ARGB32_1280x960');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

preview(vid);

start(vid);

stoppreview(vid);

imaqmem(100000000);