guard 'coffeescript', :output => 'public/javascripts/compiled' do
  watch('^app/coffeescripts/(.*)\.coffee')
end
 
guard 'coffeescript', :output => 'spec/javascripts' do
  watch('^spec/coffeescripts/(.*)\.coffee')
end
 
guard 'livereload' do
  watch('^spec/javascripts/.+\.js$')
  watch('^public/javascripts/compiled/.+\.js$')
end

guard 'coffeescript', :input => 'app/assets/javascripts'

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end
