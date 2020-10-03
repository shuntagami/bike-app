class Cc < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '~250cc(小型、原付)' },
    { id: 2, name: '250cc~400cc(中型)' },
    { id: 3, name: '400cc~(大型)' },
  ]
end
