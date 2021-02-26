function save_figure(name,subfolder)
    global folder;
    location = fullfile(folder,subfolder);
    set(gcf,'Units','inches');
    screenposition = get(gcf,'Position');
    set(gcf,...
        'PaperPosition',[0 0 screenposition(3:4)],...
        'PaperSize',screenposition(3:4));
    print('-dpdf','-painters',name)
    movefile(strcat(name,'.pdf'),location);
end

