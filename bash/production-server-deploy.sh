#!/usr/bin/env bash

# Expect to find the zip file - my-project.zip
# Scp file to production:/home/jenkins/ci with today's date
# Copy over to /srv/my-project.com
# unzip package
# remove compressed file
# switch symlinks
# restart fpm
# restart nginx

#sudo su

currentDate="$(date +%F)"

fileName="my-project-${currentDate}.zip"

deployDir="/srv/my-project.com"

currentSymlink="${deployDir}/current"

echo "Creating new directory at: ${deployDir}"

cd ${deployDir}

mkdir -p ${currentDate}
cd ${currentDate}

cp "/home/jenkins/ci/${fileName}" .

unzip ${fileName}
rm -rf ${fileName}

# in case there is no symlink try to create it first. Then delete and re-create
ln -s ${deployDir} "${deployDir}/current"

rm -rf "${deployDir}/current"

ln -s "${deployDir}/${currentDate}" ${currentSymlink}

chown -R www-data:www-data ${deployDir}

find ${deployDir} -type f -exec chmod 0644 {} \;
find ${deployDir} -type d -exec chmod 0755 {} \;


# Optional - restart web server / php-fpm
#/etc/init.d/php7.1-fpm restart
#service nginx restart

