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
  [zeroes, poles, gain] = zpkdata(transf)
  stable = isstable(transf)
  
  actions(transf, zeroes, poles, gain, stable, print_controls)
end

function actions(t, z, p, g, s)
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
      n = tfpoly2str(struct(t).num{1}, "s")
      d = tfpoly2str(struct(t).den{1}, "s")
      barra = repmat("-", 1, max(length(n), length(d)) * 10)
      printtext({n, barra, d})
    case 2
      printtext(p)
    case 3
      printtext(z)
    case 4
      printtext(g)
    case 5
      n = tfpoly2str(struct(t).num{1}, "s")
      d = tfpoly2str(struct(t).den{1}, "s")
      barra = repmat("-", 1, max(length(n), length(d)) * 10)
      printtext({n, barra, d, p, z, g})
    case 6
      subplot(2, 1, 2)
      x = -10 : 0.1 : 10;
      plot(x, t(x))
    case 7
      if s
        printtext('Estable')
      else 
        printtext('Inestable')
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

function printtext(t)
  clf
  print_controls()
  axis([0 8 0 8]);
  box on;
  axis off;
  text(
    4, ...
    4, ...
    t, ...
    "horizontalalignment", "center", ...
    "verticalalignment", "middle", ...
    "fontsize", 20
  )
end