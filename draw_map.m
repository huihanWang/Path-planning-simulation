map=[0 1 0;0 0 1;1 0 0];
start_pos=[1,1];
goal_pos=[3,3];
[height,width]=size(map);
figure;
hold on;
axis equal;
grid on;
xlim([0.5,width+0.5]);
ylim([0.5,height+0.5]);
for i=1:height
    for j=1:width
        x=j;
        y=i;
        if map(i,j)==1
            scatter(x,y,100,'k','s','filled');
        else
            scatter(x,y,100,'white','s','filled');
        end
    end
end
scatter(start_pos(2),start_pos(1),100,'green','o','filled');
scatter(goal_pos(2),goal_pos(1),100,'red','p','filled');
hold off