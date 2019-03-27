<?php

## Get current user according to entrypoint.sh

echo '<p>Exec (whoami) : ' . exec('whoami') . '</p>';
echo '<p>Current script owner: '. get_current_user() . '</p>';

phpinfo();
