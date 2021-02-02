function fish_prompt
  set pwdlen (string length (prompt_pwd))
  set cmdlen (math $COLUMNS - $pwdlen)

  # Ensure that the pwd does not take up
  # too much space
  set_color brgreen
  if test $cmdlen -lt 80
	echo (prompt_pwd)
    set_color normal
	echo -n "\$ "
  else
	echo -n (prompt_pwd)
    set_color normal
	echo -n " \$ "
  end
  set_color normal
end
