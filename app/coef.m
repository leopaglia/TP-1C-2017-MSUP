function coef

  main_figure_handler = findobj('Tag', 'main_figure');
  close(main_figure_handler);
  
  screensize = get(0, 'ScreenSize')
    sz = [800, 500]
    xpos = ceil((screensize(3)-sz(1))/2)
    ypos = ceil((screensize(4)-sz(2))/2)
  
  fig = figure(
      'Visible', 'on', ...
      'Position', [xpos, ypos, sz(1), sz(2)], ...
      'Name', 'ASIC UI', ...
      'NumberTitle', 'off'
    );
    
    % header
    uicontrol(
      'Style', 'text', ...
      'Position', [0, 500, 800, 50], ...
      'String', 'Coeficientes', ...
      'FontSize', 15
    );
    
    % num label
    uicontrol(
      'Style', 'text', ...
      'Position', [20, 450, 150, 30], ...
      'String', 'Ingrese coef. S(x)', ...
      'FontSize', 10
    );
    
    % num input
    uicontrol(
      'Style', 'edit', ...
      'Position', [170, 450, 200, 30], ...
      'Tag', 'numinput'
    );

    % den label    
    uicontrol(
      'Style', 'text', ...
      'Position', [420, 450, 150, 30], ...
      'String', 'Ingrese coef. E(x)', ...
      'FontSize', 10
    );
    
    % den input
    uicontrol(
      'Style', 'edit', ...
      'Position', [570, 450, 200, 30], ...
      'Tag', 'deninput'
    );
    
    % plot button
    plotbtn = uicontrol(
      'Style', 'pushbutton', ...
      'Position', [350, 400, 100, 30], ...
      'String', 'Acciones', ...
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
    
    [sel, ok] = listdlg (
      "ListString", {
        "Obtener expresion", ...
        "Indicar polos", ...
        "Indicar ceros", ...
        "Marcar ganancia", ...
        "Obtener expresion, polos, ceros y ganancia", ...
        "Graficar distribucion de polos y ceros", ...
        "Indicar estabilidad del sistema", ...
        "Obtener caracteristicas", ...
        "Ingresar nueva funcion", ...
        "Finalizar"
       }, ...
      "SelectionMode", "Single", ...
      "Name", "Opciones" 
    )
    
    if(ok == 0) 
      return
    end  
    
    switch sel
      case 1
        uicontrol(
          'Style', 'text', ...
          'Position', [320, 200, 150, 30], ...
          'String', 'asdasd', ...
          'FontSize', 20
        );
      case 2
        uicontrol(
          'Style', 'text', ...
          'Position', [320, 200, 150, 30], ...
          'String', char(poles), ...
          'FontSize', 20
        );
      case 3
        uicontrol(
          'Style', 'text', ...
          'Position', [320, 200, 150, 30], ...
          'String', 'asdasd', ...
          'FontSize', 20
        );
      case 4
        uicontrol(
          'Style', 'text', ...
          'Position', [320, 200, 150, 30], ...
          'String', 'asdasd', ...
          'FontSize', 20
        );
      case 5
        disp('lel')
      case 6
        subplot(2, 1, 2)
        s = -10 : 0.1 : 10;
        plot(s, transf(s))
      case 7
        if isstable
          uicontrol(
            'Style', 'text', ...
            'Position', [320, 200, 150, 30], ...
            'String', 'Funcion estable', ...
            'FontSize', 20
          );
        else 
          uicontrol(
            'Style', 'text', ...
            'Position', [320, 200, 150, 30], ...
            'String', 'Funcion inestable', ...
            'FontSize', 20
          );
        end  
      case 8
        disp('todo todito')  
      case 9
        close
        asic
      case 10
        close
    end
end