function prc

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
      'String', 'Polos, raices y ganancia', ...
      'FontSize', 15
    );

    % polos label    
    uicontrol(
      'Style', 'text', ...
      'Position', [20, 450, 100, 30], ...
      'String', 'Ingrese polos', ...
      'FontSize', 10
    );
    
    % polos input
    uicontrol(
      'Style', 'edit', ...
      'Tag', 'polesinput', ...
      'Position', [130, 450, 130, 30]
    );

    % ceros label  
    uicontrol(
      'Style', 'text', ...
      'Position', [270, 450, 100, 30], ...
      'String', 'Ingrese ceros', ...
      'FontSize', 10
    );
    
    % ceros input
    uicontrol(
      'Style', 'edit', ...
      'Tag', 'zeroesinput', ...
      'Position', [380, 450, 130, 30]
    );
    
    % ganancia label    
    uicontrol(
      'Style', 'text', ...
      'Position', [520, 450, 130, 30], ...
      'String', 'Ingrese ganancia', ...
      'FontSize', 10
    );
    
    % ganancia input
    uicontrol(
      'Style', 'edit', ...
      'Tag', 'gaininput', ...
      'Position', [660, 450, 130, 30]
    );
        
    % plot button
    plotbtn = uicontrol(
      'Style', 'pushbutton', ...
      'Position', [350, 400, 100, 30], ...
      'String', 'Acciones', ...
      'Callback', @plot_prc
    );  
end

function plot_prc(hObject, eventdata)
    zeroeshandler = findobj('Tag', 'zeroesinput');
    poleshandler = findobj('Tag', 'polesinput');
    gainhandler = findobj('Tag', 'gaininput');
    zeroesstr = get(zeroeshandler, 'string');
    polesstr = get(poleshandler, 'string');
    gainstr = get(gainhandler, 'string');
    
    zeroes = str2num(zeroesstr);
    poles = str2num(polesstr);
    gain = str2num(gainstr);
    
    transf = zpk(zeroes, poles, gain)
    [zeroes, poles, gain]
    stable = isstable(transf)
    %s = -10 : 0.1 : 10;
    %plot(s, sys(s))
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
