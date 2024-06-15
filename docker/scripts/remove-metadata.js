const host1 = process.env.MYSQL_HOST_1
const host2 = process.env.MYSQL_HOST_2
const host3 = process.env.MYSQL_HOST_3

const port1 = MYSQL_PORT_1
const port2 = MYSQL_PORT_2
const port3 = MYSQL_PORT_3

const username = process.env.MYSQL_USER
const password = process.env.MYSQL_PASSWORD

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
removeMetadata(host1, port1, user, password)
removeMetadata(host2, port2, user, password)
removeMetadata(host3, port3, user, password)