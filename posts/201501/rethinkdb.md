
#[data export && import](http://rethinkdb.com/docs/migration/)
sudo apt-get install python-pip
sudo pip install rethinkdb
rethinkdb dump --connect localhost:28015
rethinkdb restore
