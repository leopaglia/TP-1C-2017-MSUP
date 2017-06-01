function coef
  fig = figure(
      'Visible', 'on', ...
      'Position', [0, 0, 800, 500], ...
      'Name', 'ASIC UI', ...
      'NumberTitle', 'off'
    );
    
    % header
    uicontrol(
      'Style', 'text', ...
      'Position', [0, 400, 800, 100], ...
      'String', 'Coeficientes', ...
      'FontSize', 15
    );
    
    % num label
    uicontrol(
      'Style', 'text', ...
      'Position', [20, 350, 150, 30], ...
      'String', 'Ingrese coef. S(x)', ...
      'FontSize', 10
    );
    
    % num input
    uicontrol(
      'Style', 'edit', ...
      'Position', [170, 350, 200, 30], ...
      'Tag', 'numinput'
    );

    % den label    
    uicontrol(
      'Style', 'text', ...
      'Position', [420, 350, 150, 30], ...
      'String', 'Ingrese coef. E(x)', ...
      'FontSize', 10
    );
    
    % den input
    uicontrol(
      'Style', 'edit', ...
      'Position', [570, 350, 200, 30], ...
      'Tag', 'deninput'
    );
    
    % plot button
    plotbtn = uicontrol(
      'Style', 'pushbutton', ...
      'Position', [350, 200, 100, 30], ...
      'String', 'Plot', ...
      'Callback', @plot_coef
    );  
end

function plot_coef(hObject, eventdata)
    numhandler = findobj('Tag', 'numinput');
    denhandler = findobj('Tag', 'deninput');
    numstr = get(numhandler, 'string');
    denstr = get(denhandler, 'string');
    
    num = str2num(numstr);
    den = str2num(denstr);
    
    transf = tf(num, den)
    [zeroes, poles, gain] = zpkdata(transf)
    stable = isstable(transf)
    %s = -10 : 0.1 : 10;
    %plot(s, transf(s))
    %pzmap(transf)
end