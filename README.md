# Overbox

Overbox is a virtual ruby and java development environment, based on vagrant and
torquebox.

It provides a ready-to-run CentOS 5.6 vm with provisioning scripts für torquebox,
jenkins and several other tools.

Run "vagrant add project my_project" and have a look at projects/my_project to gain
a feeling how things work.

To be documented ... ;-)

## Short instructions:

- Install [VirtualBox](http://www.virtualbox.org/)
- gem install [vagrant](http://vagrantup.com/)
- cp config.example.yaml config.yaml
- vagrant add project my_project
- vagrant up
- vagrant reload
- open http://localhost:8080/jenkins
