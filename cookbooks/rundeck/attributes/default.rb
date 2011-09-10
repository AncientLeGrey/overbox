default[:rundeck][:deployment] = 'war' # war or rpm
default[:rundeck][:version]    = 'latest'
default[:rundeck][:yum_repo]   = 'http://rundeck.org/repo/rundeck/1/release'
default[:rundeck][:war]        = "http://build.rundeck.org/job/release-1.3-rc/lastSuccessfulBuild/artifact/rundeckapp/target/rundeck-1.3.0.war"
