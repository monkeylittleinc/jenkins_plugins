jenkins_plugins_ssh_key 'sam' do
  type 'rsa'
  key <<-KEY
  -----BEGIN RSA PRIVATE KEY-----
  MIIJKQIBAAKCAgEAv39xGNZys5hEU6UBvunu8nFDBrNgOmi8jmGnsZ+LPtjoekf/
  rXkWfEZe2BZCEd4GAK3OqCXJasM1fri9IG+6E9PscJZLy49PuwDAiDebKYHOEOBt
  /nvgiBvXddr9EGI/cu7ydiOEFQQwxSz+4gGQdrqBhF6t7sxswbzyNi9w9Lgi5lfd
  kBy/GV1qXlZw4JtbwF1xE5HsFc7gM54hdiZQ5ojxdA6Ylb6cUPQc9vgsVHR9DYHw
  xN+TFRe/WlABmUq5DyKzCHvK7OiUwyt1wdO2pqO6cLSIlhdB73EHOuwFg2P0foI2
  Lq0RUv8o9j9irNTawiDMa/uYUMTy6ZHjrqoMKNwfjCGbX6BOLDC5dOMBz5/haYYR
  -----END RSA PRIVATE KEY-----
  KEY
  action :add
end

jenkins_plugins_ssh_key 'sam' do
  type 'rsa'
  key <<-KEY
  -----BEGIN RSA PRIVATE KEY-----
  MIIJKQIBAAKCAgEAv39xGNZys5hEU6UBvunu8nFDBrNgOmi8jmGnsZ+LPtjoekf/
  rXkWfEZe2BZCEd4GAK3OqCXJasM1fri9IG+6E9PscJZLy49PuwDAiDebKYHOEOBt
  /nvgiBvXddr9EGI/cu7ydiOEFQQwxSz+4gGQdrqBhF6t7sxswbzyNi9w9Lgi5lfd
  kBy/GV1qXlZw4JtbwF1xE5HsFc7gM54hdiZQ5ojxdA6Ylb6cUPQc9vgsVHR9DYHw
  xN+TFRe/WlABmUq5DyKzCHvK7OiUwyt1wdO2pqO6cLSIlhdB73EHOuwFg2P0foI2
  Lq0RUv8o9j9irNTawiDMa/uYUMTy6ZHjrqoMKNwfjCGbX6BOLDC5dOMBz5/haYYR
  -----END RSA PRIVATE KEY-----
  KEY
  action :remove
end
