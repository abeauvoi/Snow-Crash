# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    snow-crash.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: abeauvoi <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/28 18:56:21 by abeauvoi          #+#    #+#              #
#    Updated: 2020/02/29 00:54:17 by abeauvoi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/usr/bin/env bash

# get decrypted password for flag00 user
cat $(find /usr -group "flag00") | tr 'A-Za-z' 'L-ZA-Kl-za-k'

su flag00
# enter password
# get encrypted password for flag01 user
cat /etc/passwd | grep flag01 | cut -d ':' -f 2

su flag01
