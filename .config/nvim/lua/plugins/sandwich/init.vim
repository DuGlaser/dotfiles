let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
      \    {'buns': ['${', '}'], 'input': ['jsx']}
      \  ]
