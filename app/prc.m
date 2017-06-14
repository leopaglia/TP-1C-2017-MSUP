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

  print_controls()
end

function print_controls
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
    [zeroes, poles, gain] = tf2zp(transf)
    stable = isstable(transf)

    n = tfpoly2str(struct(transf).num{1}, "s")
    d = tfpoly2str(struct(transf).den{1}, "s")
    barra = repmat("-", 1, max(length(n), length(d)) + 5)
    expresion = {n, barra, d}

    actions(transf, zeroes, poles, gain, stable, print_controls, expresion)
  end

  function actions(t, z, p, g, s, e)
    [sel, ok] = listdlg (
      "ListSize", [100], ...
      "ListString", {
        "1. Obtener expresion", ...
        "2. Indicar polos", ...
        "3. Indicar ceros", ...
        "4. Marcar ganancia", ...
        "5. Obtener expresion, polos, ceros y ganancia", ...
        "6. Graficar distribucion de polos y ceros", ...
        "7. Indicar estabilidad del sistema", ...
        "8. Obtener caracteristicas", ...
        "9. Ingresar nueva funcion", ...
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
        printtext(e)
      case 2
        printtext(mat2str(p))
      case 3
        printtext(mat2str(z))
      case 4
        printtext(num2str(g))
      case 5
        limpiarPantalla()
        mostrarTexto(e)
        mostrarTexto(mat2str(z), 2, 4)
        mostrarTexto(mat2str(p), 1, 4)
        mostrarTexto(num2str(g), 0, 4)
      case 6
        limpiarPantalla()
        mostrarGrafico(t)
      case 7
        printtext(ifelse(s, 'Estable', 'Inestable'))
      case 8
        limpiarPantalla()
        mostrarTexto(e, 5, 4)
        mostrarTexto(mat2str(z), 3, 4)
        mostrarTexto(mat2str(p), 2, 4)
        mostrarTexto(num2str(g), 1, 4)
        mostrarTexto(ifelse(s, 'Estable', 'Inestable'), 0, 4)
        mostrarGrafico(t)
      case 9
        close
        asic
      case 10
        close
    end
  end

  function printtext(t)
    limpiarPantalla()
    mostrarTexto(t)
  end

  function mostrarGrafico(t)
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
    plot(2, 1, 2)
    pzmap(t)
  end

  function mostrarTexto(texto, x = 4, y = 4)
    text(
      y, ...
      x, ...
      texto, ...
      "horizontalalignment", "center", ...
      "verticalalignment", "middle", ...
      "fontsize", 20
    );
  end

  function limpiarPantalla()
    clf
    print_controls()
    axis([0 8 0 8]);
    box on;
    axis off;
  end
