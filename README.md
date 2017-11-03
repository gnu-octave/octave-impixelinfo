# octave-impixelinfo

Playground to develop impixelinfo and impixelinfoval

See patch https://savannah.gnu.org/patch/?8722

These functions should be included into the octave-forge image package if ready.

# discussion on IRC

I just looked at your impixelinfo. I think that should be done as impixelinfoval. Matlab seems to include the impixelinfoval control inside the other so it probably impixelinfo calls impixelinfoval. 

Do you understand this? "...When created with impixelinfo, the tool is a uipanel object.... When created with impixelinfoval, the tool is a uicontrol object...  I'm not familiar with ui* object and thought a uicontrol style=text is the same as a panel 

a control is element that you can interact with such as button, piece of text, dropdown menu, etc. A panel is just a place where you can put stuff (other panels or a control) so what that sentence means is that impixelinfoval will create a uicontrol with the text only. If you use impixelinfo, then it creates a panel with the text "Pixel Info" which is followed by a uicontrol (the one that created by impixelinfoval) that shows the actual pixelinfp   this separation of things allows you to place the pixelinfo somewhere else, in your own uipanel 
