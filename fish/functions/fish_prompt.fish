function fish_prompt
  set pwdlen (string length (prompt_pwd))
  set cmdlen (math $COLUMNS - $pwdlen)
  # $random_prompt_color comes from config.fish

  # Ensure that the pwd does not take up
  # too much space
  if test $cmdlen -lt 80
    set_color brgreen
	echo (prompt_pwd)
	set_color $random_prompt_color
	echo -n "% "
  else
    set_color brgreen
	echo -n (prompt_pwd)
	set_color $random_prompt_color
	echo -n " % "
  end
  set_color normal
end
