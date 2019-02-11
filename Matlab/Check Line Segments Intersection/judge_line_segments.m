
function [answer] = judge_line_segments (P11,P12,P21,P22)

x11=P11(1);
y11=P11(2);

x12=P12(1);
y12=P12(2);

x21=P21(1);
y21=P21(2);

x22=P22(1);
y22=P22(2);


function yesdialog
    E = dialog('Position',[300 300 250 150],'Name','My Dialog');

     uicontrol('Parent',E,...'Style','text',...
        'Position',[20 80 210 40],...
               'String','Yes, two segments intersect');

     uicontrol('Parent',E,...
               'Position',[85 20 70 25],...
               'String','Close',...
               'Callback','delete(gcf)');

end

function nodialog
    F = dialog('Position',[300 300 250 150],'Name','My Dialog');

     uicontrol('Parent',F,...'Style','text',...
        'Position',[20 80 210 40],...
               'String','No, two segments does not intersect');

     uicontrol('Parent',F,...
               'Position',[85 20 70 25],...
              'String','Close',...
               'Callback','delete(gcf)');

end


%line segment1
a=((y21-y11)*(x12-x11)) - ((y12-y11)*(x21-x11));
b=((y22-y11)*(x12-x11)) - ((y12-y11)*(x22-x11));
%line segment2
c=((y11-y21)*(x22-x21))- ((y22-y21)*(x11-x21));
d=((y12-y21)*(x22-x21))- ((y22-y21)*(x12-x21)); 

G = times(a,b) ;
H = times(c,d);

if  G>0  %same side 
    nodialog;
    disp('a');
    
elseif  G == 0 %on the line       
        if   H == 0  %2nd point. 
            if (y11<=y21 && y21<=y12) || (y11<=y22 && y22<=y12) || (y12<=y21 && y21<=y11) || (y12<=y22 && y22<=y11)
                yesdialog;
                disp('b');
            else
                nodialog;
                disp('c');
            end
            
        elseif (y11<=y21 && y21<=y12) || (y11<=y22 && y22<=y12) || (y12<=y21 && y21<=y11) || (y12<=y22 && y22<=y11)
                yesdialog;
                disp('d');
            else
                nodialog;
                disp('e');
        end
              
elseif G<0 
    if H>0 %same side
        nodialog;
    elseif H==0 
                if (y21<=y11 && y11<=y22) || (y21<=y12 && y12<=y22) || (y22<=y11) && (y11<=y21) || (y22<=y12 && y12<=y21)
                    yesdialog;
                    disp('f');
                else
                    nodialog;
                    disp('g');
                end
    elseif H<0
               yesdialog;
               disp('h');
    end       
end


end
