function OutputImage = Myrotate(InputImage, degree)
%The function replace the imrotate furntcion
%For grayscale image e.g. MRI
    [row,col]=size(InputImage);

    new_H=round(row*abs(cosd(degree)))+round(col*abs(sind(degree)));%The height of the new image
    new_W=round(row*abs(-sind(degree)))+round(col*abs(cosd(degree)));%The width of the new image
    OutputImage=zeros(new_H,new_W);

%Design the rotation matrix
    M1=[1,0,-row/2;0,-1,col/2;0,0,1];%move the coordinates origin
    M2=[cosd(degree),sind(degree),0;-sind(degree),cosd(degree),0;0,0,1];%rotation matrix
    M3=[1,0,new_W/2;0,-1,new_H/2;0,0,1];%move the origin back

    for m =1:new_H
        for n =1:new_W
            Original_Pos=inv(M1)*inv(M2)*inv(M3)*[m;n;1];%The new position (m,n) original position (Original_X,Original_Y)
            Original_X=round(Original_Pos(1));
            Original_Y=round(Original_Pos(2));
            if(Original_X>=1&&Original_X<=row)&&(Original_Y>=1&&Original_Y<=col)
                OutputImage(m,n)=InputImage(Original_X,Original_Y);
            end
        end
    end

%display both figures
    figure;
    subplot(1,2,1);
    imagesc(InputImage);
    title('Input Image');
    xlabel('x');ylabel('y');

    subplot(1,2,2);
    imagesc(OutputImage);
    colormap('gray');
    title('Output Image');
    xlabel('x');ylabel('y');
    fprintf('The rotation process has been finished, the rotation degree is %.2f\n',degree);

end



