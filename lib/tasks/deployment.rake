namespace :cf do
  namespace :deploy do
    desc 'Pushes an app to sydney on Cloud Foundry'
    task :sydney do
      Evaporator::Deployer.new('config/cf-sydney.yml').deploy
    end
  end
end
