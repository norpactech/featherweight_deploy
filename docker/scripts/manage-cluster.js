// TODO: Discover how to use env vars (i.e. process.env...)

const host1 = 'mysql-server-1'
const host2 = 'mysql-server-2'
const host3 = 'mysql-server-3'

const port1 = '3306'
const port2 = '3306'
const port3 = '3306'

const username = 'root'
const password = 'password'

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
  shell.connect(`${username}@${host1}:${port1}`, 'password')
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