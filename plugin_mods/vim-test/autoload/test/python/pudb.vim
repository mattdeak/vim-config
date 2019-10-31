
if !exists('g:test#python#pudb#file_pattern')
  let g:test#python#pudb#file_pattern = '\v(test_[^/]+|[^/]+_test)\.py$'
endif 
function! test#python#pudb#test_file(file) abort
  if fnamemodify(a:file, ':t') =~# g:test#python#pudb#file_pattern
    if exists('g:test#python#runner')
      return g:test#python#runner ==# 'pudb'
    else
      return executable("python")
    endif
  endif
endfunction

function! test#python#pudb#build_position(type, position) abort
  let path = s:get_import_path(a:position['file'])
  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      return [path, name]
    else
      return [path]
    endif
  elseif a:type ==# 'file'
    return [path]
  else
    return []
  endif
endfunction


function! test#python#pudb#build_args(args) abort
  return a:args
endfunction

function! test#python#pudb#executable() abort
  return 'python -m pudb'
endfunction

function! s:get_import_path(filepath) abort
  " Get path to file from cwd and without extension.
  let path = fnamemodify(a:filepath, ':.')
  " Replace the /'s in the file path with .'s
  return path
endfunction


function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#python#patterns)
  return join(name['namespace'] + name['test'], '.')
endfunction

function! s:separator() abort
  let python_runner = get(g:, 'test#python#runner', 'pudb')
  return {'pudb': '.'}[python_runner]
endfunction
