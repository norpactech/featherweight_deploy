// TODO: Discover how to use env vars (i.e. process.env...)

const host1 = 'mysql-server-1'
const host2 = 'mysql-server-2'
const host3 = 'mysql-server-3'

const port1 = '3306'
const port2 = '3306'
const port3 = '3306'

const username = 'root'
const password = 'password'

function removeMetadata(host, port, user, password) {

  try {
    const connect = `${username}@${host1}:${port1}`
    print(`Initiating connection: ${connect}`)
    shell.connect(connect, password)
    print('Connection successfull')
    dba.dropMetadataSchema({force: true});
    print('Metadata removal successfull')
  }
  catch (e) {
    print(`Metadata removal failure ${e.message}`)
  }
}
removeMetadata(host1, port1, username, password)
removeMetadata(host2, port2, username, password)
removeMetadata(host3, port3, username, password)