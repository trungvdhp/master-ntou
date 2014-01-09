% Script File: ShowLineWidth

close all
plot([0 14 14 0 0],[0 0 14 14 0])
text(7,13,'LineWidth','FontSize',18,'HorizontalAlign','center')
axis off
hold on
for width=0:10
   h = plot([3 12],[11-width 11-width]);
   if width>0
      set(h,'LineWidth',width)
      text(1,11-width,sprintf('%3d',width),'FontSize',14)
   else
      text(1,11-width,'default','FontSize',14)
   end
end
hold off

