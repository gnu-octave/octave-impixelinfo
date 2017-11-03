## Copyright (C) 2016 Andreas Weber <octave@tech-chat.de>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn  {Function File} {} impixelinfo ()
## @deftypefnx {Function File} {} impixelinfo (@var{h})
## @deftypefnx {Function File} {} impixelinfo (@var{hparent}, @var{himage})
## @deftypefnx {Function File} {@var{hpanel} =} impixelinfo (@dots{})
## Create a uipanel with pixel values in the current figure.
##
## FIXME: document me!
## Should work with graphics_toolkit qt
##
## This won't work with FLTK in Octave <= 4.0
## This also doesn't work with gnuplot
##
## @end deftypefn

function varargout = impixelinfo (varargin)

  if (nargin > 1)
    print_usage ();
  endif

  if (nargin == 0)
    h = gcf ();
  elseif (nargin >= 1)
    h = varargin {1};
  endif

  if (nargin == 2)
    himg = varargin {2};
  else
    himg = findobj (h, "type", "image");
  endif

  ## create uipanel
  h = uipanel (h,
               "Units","characters",...
               "tag", "__impixelinfo_panel__",...
               "Position",[0 0 10 1.2]);

  impixelinfoval (h, himg);

endfunction

%!demo
%! img = rand (10, 15);
%! imagesc (img);
%! impixelinfo ();
