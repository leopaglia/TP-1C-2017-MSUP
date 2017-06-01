function asic
    % init libraries
    pkg load control
    
    % clear console
    clc
    clear

    fig = figure(
      'Visible', 'on', ...
      'Position', [0, 0, 800, 500], ...
      'Name', 'ASIC UI', ...
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