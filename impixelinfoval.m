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
## @deftypefn {Function File} {@var{hcontrol} =} impixelinfoval (@var{hparent}, @var{himage})
## Create a pixel information tool.
##
## FIXME: document me!
## Should work with graphics_toolkit qt
##
## This won't work with FLTK in Octave <= 4.0
## This also doesn't work with gnuplot
##
## @end deftypefn

function varargout = impixelinfoval (hparent, himage)

  if (nargin != 2)
    print_usage ();
  endif

  txt = uicontrol(hparent, "Style","text",...
        "HorizontalAlignment", "Left",...
        "Units","characters",...
        "Position",[0 0 10 1],...
        "tag", "__impixelinfoval_tool__",...
        "String", "no image");

  while (! isfigure (hparent))
    hparent = get (hparent, "parent");
  endwhile

  set (hparent, "WindowButtonMotionFcn", @impixelinfoval_windowbuttonmotionfcn);

endfunction

function impixelinfoval_windowbuttonmotionfcn (obj)

  ## We might get multiple images, for example subplots
  ## or an image with colorbar
  himg = findobj (obj, "type", "image");
  tool = findobj (obj, "tag", "__impixelinfoval_tool__");

  found_img = false;
  for k=1:numel (himg)

    ax  = get (himg (k), "parent");
    point = get (ax, "currentpoint");
    x = round (point (1, 1));
    y = round (point (1, 2));

    ## FIXME: Perhaps we should use impixel here
    img = get (himg (k), "cdata");
    v = NA;
    if (x > 0 && y > 0 && x <= columns (img) && y <= rows (img))
      v = squeeze (img(y, x, :));

      #printf ("isbw = %i, ", isbw (img));
      #printf ("isgray = %i, ", isgray (img));
      #printf ("isind = %i, ", isind (img));
      #printf ("isrgb = %i\n", isrgb (img));
      #fflush (stdout);

      str = "";
      ## Is the tool inside a panel generated from impixelinfo?
      tool_parent = get (tool, "parent");
      tool_parent_is_panel = strcmp (get (tool_parent, "tag"), "__impixelinfo_panel__");

      if (tool_parent_is_panel)
        str = sprintf ("Pixel Info: ");
      endif

      str = [str sprintf("(%i, %i)",x,y)];

      s2 = sprintf (" %i", v);
      if (isrgb (img))
        str = [str sprintf(" [%i %i %i]",v)];
      else
        str = [str sprintf(" %i)",v)];
      endif
      ## FIMXE: handle indexed images

      set (tool, "String", str);
      found_img = true;

      ## increase size of uicontrol and uipanel if needed
      ## FIMXE: Looks like there is a problem with Octave's "extent" property
      ext = get (tool, "extent");
      pos = get (tool, "Position");
      if (pos(3) < ext(3))
        pos(3) = 1.6 * ext(3);
        set (tool, "Position", pos);
        if (tool_parent_is_panel)
          pos(4) *= 1.2;
          set (tool_parent, "Position", pos);
        endif
      endif
    endif

  endfor

  if (! found_img)
    set (tool, "String", "no image");
  endif

endfunction
