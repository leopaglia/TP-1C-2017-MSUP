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

  print_controls()
end

function print_controls
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
