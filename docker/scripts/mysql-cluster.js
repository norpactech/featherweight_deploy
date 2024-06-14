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
  var cluster = dba.createCluster(clusterName);
  cluster.addInstance('root@mysql-server-2', {recoveryMethod: 'clone'})
  cluster.addInstance('root@mysql-server-3', {recoveryMethod: 'clone'})
}

function manageCluster() {

  print(`Connecting to mysql-server-1...\n`)
  shell.connect('root@mysql-server-1:3306', password)
  print(`Connected\n`)
  print(`hc\n`)
  try {
    const { name, status } = healthCheck()
    print(`Cluster: '${name}' status: '${status}'\n`)
    return // no error thrown
  }
  catch (e) {
    const { code, message } = e
    if (code == 51314) {
      print(`No Cluster Available. Attempting to reboot. Error message is: ${message}\n`)
      dba.rebootClusterFromCompleteOutage()
    }
    if (code == 51300) {
      print(`No Cluster Available. Attempting to create. Error message is: ${message}\n`)
      createCluster('mysql-cluster')
    }
  }
}

manageCluster()