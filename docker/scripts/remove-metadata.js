var config = require('./config');

const host1 = config.MYSQL_HOST_1
const host2 = config.MYSQL_HOST_2
const host3 = config.MYSQL_HOST_3

const port1 = config.MYSQL_PORT_1
const port2 = config.MYSQL_PORT_2
const port3 = config.MYSQL_PORT_3

const username = config.MYSQL_USERNAME
const password = config.MYSQL_PASSWORD

function removeMetadata(host, port, username, password) {

  try {
    const connect = `${username}@${host}:${port}`
    print(`Initiating connection: ${connect}\n`)
    shell.connect(connect, password)
    print('Connection successfull\n')
    dba.dropMetadataSchema({force: true});
    print('Metadata removal successfull\n')
  }
  catch (e) {
    print(`Metadata removal failure ${e.message}\n`)
  }
}
removeMetadata(host1, port1, username, password)
removeMetadata(host2, port2, username, password)
removeMetadata(host3, port3, username, password)