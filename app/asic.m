function asic
    % init libraries
    pkg load control
    
    % clear console
    clc
    clear
    
    screensize = get(0, 'ScreenSize')
    sz = [800, 500]
    xpos = ceil((screensize(3)-sz(1))/2)
    ypos = ceil((screensize(4)-sz(2))/2)

    fig = figure(
      'Visible', 'on', ...
      'Position', [xpos, ypos, sz(1), sz(2)], ...
      'Name', 'ASIC UI', ...
      'Tag', 'main_figure', ...
      'NumberTitle', 'off'
    );
    
    % header
    uicontrol(
      'Style', 'text', ...
      'Position', [0, 300, 800, 200], ...
      'String', 'ASIC', ...
      'FontSize', 35
    );
    
    % coef button
    uicontrol(
      'Style', 'pushbutton', ...
      'Position', [40, 40, 340, 220], ...
      'String', 'Ingresar coeficientes', ...
      'Callback', @coef
    );
    
    % prc button
    uicontrol(
      'Style', 'pushbutton', ...
      'Position', [420, 40, 340, 220], ...
      'String', 'Ingresar polos, raices y ganancia', ...
      'Callback', @prc
    );                                            
end