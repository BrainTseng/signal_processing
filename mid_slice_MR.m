function mid_slice_MR(inputMRI)
% A function which takes as an input a 3D volume and displays themid-axial,
% mid-sagittal and mid-coronal view in the same figure.
% The input should be a 3d MRI image.

%mid-axial
image_axial_matrix=squeeze(inputMRI(:,:,floor(size(inputMRI,3)/2)));
axial_image=imagesc(image_axial_matrix);

%mid-sagittal
image_sag_matrix=squeeze(inputMRI(floor(size(inputMRI,1)/2),:,:));
sagittal_image=imagesc(image_sag_matrix);

%mid-coronal
image_cor_matrix=squeeze(inputMRI(:,floor(size(inputMRI,2)/2),:));
coronal_image=imagesc(image_sag_matrix);

figure(1)
subplot(2,2,1);
axial=imagesc(imrotate(image_axial_matrix,90));
colormap('gray')
xlabel('x');
ylabel('y');
title('Axial plane');

subplot(2,2,2);
sagittal=imagesc(imrotate(image_sag_matrix,90));
colormap('gray')
xlabel('y');
ylabel('z');
title('Sagittal plane');

subplot(2,2,3);
coronal=imagesc(imrotate(image_cor_matrix,90));
colormap('gray')
xlabel('x');
ylabel('z');
title('Coronal plane');
bar

end

