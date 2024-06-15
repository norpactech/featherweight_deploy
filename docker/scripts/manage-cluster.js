var config = require('./config');

const host1 = config.MYSQL_HOST_1
const host2 = config.MYSQL_HOST_2
const host3 = config.MYSQL_HOST_3

const port1 = config.MYSQL_PORT_1
const port2 = config.MYSQL_PORT_2
const port3 = config.MYSQL_PORT_3

const username = config.MYSQL_USERNAME
const password = config.MYSQL_PASSWORD

function healthCheck() {  
  var cluster = dba.getCluster()
  var { name, status } = cluster.status().defaultReplicaSet
  
  return {
    name: name,
      status: status
  }
}

function createCluster(clusterName) {
  var cluster = dba.createCluster('mysql-cluster')
  cluster.addInstance(`${username}@${host2}:${port2}`, {recoveryMethod: 'clone'})
  cluster.addInstance(`${username}@${host3}:${port3}`, {recoveryMethod: 'clone'})
}

function manageCluster() {

  print(`Connecting to ${host1}...\n`)
  shell.connect(`${username}@${host1}:${port1}`, password)
  print(`Connected\n`)

  try {
    const { name, status } = healthCheck()
    print(`Cluster: '${name}' status: '${status}'\n`)
    return // no error thrown
  }
  catch (e) {
    const { code, message } = e
    if (code == 51314) {
      print(`No Cluster Available. Attempting to reboot. Error message is: ${message}\n`)
      try {
        dba.rebootClusterFromCompleteOutage()
      }
      catch (e2) {
        print(`Panic!!! Reboot failure. Were your containers deleted then rebuilt? Cluster rebuild is required. Use interactive mode an run scripts/teardown-cluster.js\n`)
      }
    }
    if (code == 51300) {
      print(`No Cluster Available. Attempting to create. Error message is: ${message}\n`)
      createCluster('mysql-cluster')
    }
  }
}
manageCluster()