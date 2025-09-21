map=[0,0,0,0,0;0,1,1,1,0;0,0,0,0,0;0,1,0,1,0;0,0,0,0,0];
start_node=[1,1];
goal_node=[5,5];
figure;
clf;
hold on;
axis equal;
axis([0.5,cols+0.5,0.5,rows+0.5]);
grid on;
plot(start_node(2),start_node(1),'go','MarkerSize',10,'MarkerFaceColor','g');
plot(goal_node(2),goal_node(1),'ro','MarkerSize',10,'MarkerFaceColor','r');
for i=1:rows
    for j=1:cols
        if map(i,j)==1
            fill([j-0.5,j+0.5,j+0.5,j-0.5],[i-0.5,i-0.5,i+0.5,i+0.5],'k');
        else
            fill([j-0.5,j+0.5,j+0.5,j-0.5],[i-0.5,i-0.5,i+0.5,i+0.5],'w');
        end
    end
end
plot(start_node(2),start_node(1),'go','MarkerSize',10,'MarkerFaceColor','g');
plot(goal_node(2),goal_node(1),'ro','MarkerSize',10,'MarkerFaceColor','r');
open_plot=[];
close_plot=[];
current_plot=[];
path_plot=[];
closelist=[];
openlist=[];
h_start=abs(goal_node(1)-start_node(1))+abs(goal_node(2)-start_node(2));
openlist=[start_node,0+h_start,0,h_start,0,0];
path_found=false;
while ~isempty(openlist)&& ~path_found
    [~,min_idx]=min(openlist(:,3));
    current_node=openlist(min_idx,1:2);
    current_idx=min_idx;
    if isequal(current_node,goal_node)
        path_found=true;
        fprintf('找到路径\n');
        break;
    end
    neighbors=[];
    [rows,cols]=size(map);
    i=current_node(1);
    j=current_node(2);
    if i>1
        neighbors=[neighbors;i-1,j];
    end
    if i<rows
        neighbors=[neighbors;i+1,j];
    end
    if j>1
        neighbors=[neighbors;i,j-1];
    end
    if j<cols
        neighbors=[neighbors;i,j+1];
    end
    if ~isempty(open_plot)
        delete(open_plot);
    end
    if ~isempty(close_plot)
        delete(close_plot);
    end
    if ~isempty(current_plot)
        delete(current_plot);
    end
    if ~isempty(openlist)
        open_plot=plot(openlist(:,2),openlist(:,1),'mo','MarkerSize',8);
    end
    if ~isempty(closelist) && size(closelist, 2) >= 2
        close_plot = plot(closelist(:,2), closelist(:,1), 'bo', 'MarkerSize', 6);
    else
        disp('closelist 为空或列数不足，跳过绘制');
    end
    current_plot=plot(current_node(:,2),current_node(:,1),'ro','MarkerSize',10,'LineWidth',2);
    drawnow;
    pause(0.5);
    for n=1:size(neighbors,1)
        neighbor=neighbors(n,:);
        ni=neighbor(1);
        nj=neighbor(2);
        if map(ni,nj)==1
            continue;
        end
        if isempty(closelist)
        else
            if ~isempty(closelist)&&any (ismember(closelist(:,1:2),neighbor,'rows'))
                continue;
            end
        end
        in_openlist=false;
        openlist_idx=0;
        for k=1:size(openlist,1)
            if isequal(openlist(k,1:2),neighbor)
                in_openlist=true;
                openlist_idx=k;
                break;
            end
        end
        g=openlist(current_idx,4)+1;
        h=abs(goal_node(1)-ni)+abs(goal_node(2)-nj);
        f=g+h;
        if ~in_openlist
            openlist=[openlist;neighbor,f,g,h,current_node];
        else
            if g<openlist(openlist_idx,4)
                openlist(openlist_idx,3:7)=[f,g,h,current_node];
            end
        end
    end
    closelist=[closelist;openlist(current_idx,:)];
    openlist(current_idx,:)=[];
end
if path_found
    path=[];
    current=goal_node;
    while ~isequal(current,start_node)
        path=[current;path];
        found=false;
        for i=1:size(openlist,1)
            if isequal(openlist(i,1:2),current)
                current=openlist(i,6:7);
                found=true;
                break;
            end
        end
        if ~found
            for i=1:size(closelist,1)
                if isequal(closelist(i,1:2),current)
                    current=closelist(i,6:7);
                    found=true;
                    break;
                end
            end
        end
        if ~found
            error('无法回溯路径');
        end
    end
    path=[start_node;path];
    fprintf('路径:\n');
    disp(path);
else
    fprintf('没有找到路径\n');
end
if path_found
    if ~isempty(open_plot)
        delete(open_plot);
    end
    if ~isempty(close_plot)
        delete(close_plot);
    end
    if ~isempty(current_plot)
        delete(current_plot);
    end
    plot(path(:,2),path(:,1),'b-','LineWidth',2);
    plot(path(:,2),path(:,1),'bo','LineWidth',5);
    drawnow;
end
title('A算法路径规划结构');
hold off;

    
    
