% Script File: ShowFonts

close all
HA = 'HorizontalAlign';

fonts = {'Times-Roman' 'Helvetica' 'AvantGarde' 'Bookman' 'Palatino'...
         'ZapfChancery' 'Courier' 'NewCenturySchlbk' 'Helvetica-Narrow'};
for k=1:9
   figure
   plot([-10 100 100 -10 -10],[0  0  60  60  0])
   axis([-10 100 0 60])
   axis off
   v=38;
   F = fonts{k};  
   text(45,55,F,'FontName',F,'FontSize',24,HA,'center')
   text(10,47,'Plain','FontName',F,'FontSize',22,HA,'center')
   text(45,47,'Bold','FontName',F,'Fontweight','bold','FontSize',22,HA,'center')
   text(82,47,'Oblique','FontName',F,'FontAngle','oblique','FontSize',22,HA,'center')
   for size=[22 18 14 12 11 10 9]
      text(10,v,'Matlab','FontName',F,'FontSize',size,HA,'center')
      text(45,v,'Matlab','FontName',F,'FontSize',size,HA,'center','FontWeight','bold')
      text(82,v,'Matlab','FontName',F,'FontSize',size,HA,'center','FontAngle','oblique')
      v = v-6;
   end
end

