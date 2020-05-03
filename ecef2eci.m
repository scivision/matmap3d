function [x,y,z] = ecef2eci(utc, x_ecef, y_ecef, z_ecef)
% rotate ECEF coordinates to ECI
% because this doesn't account for nutation, etc. error is often > 1%
%
% x_ecef, y_ecef, z_ecef:  ECEF position (meters)
% utc: time UTC

% x,y,z:  ECI position

narginchk(4,4)
validateattributes(utc, {'numeric', 'datetime'}, {'vector'})
validateattributes(x_ecef, {'numeric'}, {'vector'})
validateattributes(y_ecef, {'numeric'}, {'vector', 'numel', length(x_ecef)})
validateattributes(z_ecef, {'numeric'}, {'vector', 'numel', length(y_ecef)})
%% Greenwich hour angles (radians)
% gst = greenwichsrt(juliandate(datetime(utc)));
gst = greenwichsrt(juliantime(utc));
validateattributes(gst, {'numeric'}, {'vector', 'numel', length(x_ecef)})
%% Convert into ECEF
x = nan(length(gst));
y = nan(length(x));
z = nan(length(x));

for j = 1:length(x)
  eci = R3(gst(j)).' * [x_ecef(j), y_ecef(j), z_ecef(j)].';
  x(j) = eci(1);
  y(j) = eci(2);
  z(j) = eci(3);
end
end
