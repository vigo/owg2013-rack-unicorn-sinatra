# Özgür Web Günleri 2013
## Rack Uygulamalarını NginX ve Unicorn’la Koşturma

### basic-rackapp
En temel haliyle olabilecek en basit **rack uygulaması** örneği. Eğer 
makinenizde herhangi bir `ruby` sürümü kuruluysa;

	cd basic-rackapp/
	bundle install --path=vendor/bundle
	bundle exec rackup config.ru

ve;
	
	http://127.0.0.1:9292/

### sinatra-nginx-unicorn
Bu uygulama için örnek proje tamamen [Vagrant][01] üzerinde geliştirilmiştir.
Eğer vagrant kuruluysa hemen `precise32` box'dan yeni bir box üretip işimize
bakabiliriz.

	mkdir -p ~/Desktop/VagrantBoxes
	cd ~/Desktop/VagrantBoxes/
	vagrant init precise32

Daha sonra hemen `Vagrantfile` dosyasını açıp, test amaçlı;

	config.vm.network :private_network

satırını bulup;

	config.vm.network :private_network, ip: "192.168.33.101"

yaptıktan sonra;

	vagrant up
	vagrant ssh

sanal makineye girdikten sonra;
	
	# sanal makine içindesiniz
	sudo aptitude update
	sudo aptitude install -y git-core # eğer varsa kurmayın!

daha sonra bu repository'i klone'layın:

	# sanal makine içinde
	cd
	git clone https://github.com/vigo/owg2013-rack-unicorn-sinatra.git
	
	bash owg2013-rack-unicorn-sinatra/scripts/install.sh

şeklinde tüm projeyi kurabilirsiniz. Sırasıyla;

* [rbenv][02]
* [ruby-build][03]
* **ruby 1.9.3-p448**
* [Bundler][04]
* Projeye ait `Gemfile` daki `gem`ler
* [nginx][05]
* unicorn_d (unicornd_my_unicorn_application)

kurulumu yapılır. Kurulumdan sonra yapmanı gereken web tarayıcıs açıp:

	http://192.168.33.101:8080

adresine gitmek!

Eğer `unicornd_my_unicorn_application` servis olarak her makine açıldığında
çalışmasını istiyorsanız:

	# sanal makine içinde
	sudo update-rc.d unicornd_my_unicorn_application defaults

[01]: http://vagrantup.com "Vagrant"
[02]: https://github.com/sstephenson/rbenv "rbenv"
[03]: https://github.com/sstephenson/ruby-build "ruby-build"
[04]: http://bundler.io/ "Bundler"
[05]: http://nginx.org/ "Nginx"