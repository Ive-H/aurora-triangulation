function radians_angle = rad(deg,min,sec)
radians_angle = (deg + min/60 + sec/3600) * pi / 180;