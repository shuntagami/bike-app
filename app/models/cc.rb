class Cc < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '~250cc' },
    { id: 2, name: '250cc~400cc' },
    { id: 3, name: '400cc~' },
  ]
end
