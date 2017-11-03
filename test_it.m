close all
pkg load image

figure (1)
img = rand (10, 15);
h = imagesc (img);
title ("imagesc 0..1 10x15");
impixelinfoval (gcf, h);

figure (2)
img = uint8(randi(256, 10, 15) - 1);
h = image (img);
title ("image uint8 0..255 10x15");
impixelinfoval (gcf, h);

figure (3)
subplot (2, 1, 1)
img = rand (10, 15);
h1 = imagesc (img);
title ("imagesc 0..1 10x15");
impixelinfoval (gcf, h1);

subplot (2,1,2)
img = uint8(randi(256, 10, 15) - 1);
h2 = image (img);
title ("image uint8 0..255 10x15");
impixelinfoval (gcf, h2);

figure (4)
img = uint8 (randi (256, 10, 15, 3) - 1);
h = image (img);
title ("image uint8 0..255 10x15x3 RGB");
impixelinfoval (gcf, h);

figure (5)
img = logical (randi (2, 10, 15) - 1);
h = image (img);
title ("image logical 0..1 10x15 BW");
impixelinfoval (gcf, h);


## FIXME: add indexed image

#impixelinfo ()

