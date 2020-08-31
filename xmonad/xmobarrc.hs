Config {
		font = "xft:IBM Plex Mono Medium:size=11,Noto Sans Mono CJK SC-11:bold"
                , additionalFonts = [ "xft:FontAwesome:style=Solid:pixelsize=12" ]
		-- , alpha = 230
		, border = NoBorder
		, hideOnStart = False
		, position = Top
		, bgColor = "#361563"
		, fgColor = "#aac7d1"
		, template = " %StdinReader%}{%swap% %memory% %multicpu% %battery% %wlp2s0% %date% "
		, allDesktops = True

		, commands =
		[
        Run StdinReader
        , Run Network "wlp2s0" ["-t", "<fc=#26f02c>上:<tx></fc> <fc=#eb2828>下:<rx></fc>"
                  , "--minwidth", "8"
                  , "--maxwidth", "8"
                , "-S", "True"] 10
      , Run Memory [ "-t", "Mem: <usedratio>%" ] 10
      , Run Battery [ "--template", "Batt: <left>%" ] 50
      , Run Swap [] 10
      -- always 0% anyways , Run Swap [] 10
      , Run MultiCpu ["-t", "CPU: <total>%" ] 10     
      , Run Date "<fc=#ffb044> %a %b %d %T %Z</fc>" "date" 10
		]
}
