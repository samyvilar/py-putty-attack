__author__ = 'samyvilar'

import os
import inspect
import numpy
import ctypes
import multiprocessing


_libputty = numpy.ctypeslib.load_library('libputty',
    os.path.dirname(inspect.getfile(inspect.currentframe())))

_libputty.check_phrase.restype = ctypes.c_int
_libputty.check_phrase.argtypes = [ctypes.c_char_p, ctypes.c_char_p]


def check_putty_phrase(kwargs):
    putty_file = kwargs['putty_file']
    phrase = kwargs['phrase']
    if not os.path.isfile(putty_file):
        raise ValueError('% cant be found or isnt a file!' % putty_file)
    return _libputty.check_phrase(putty_file, phrase) if True else False

def test():
    phrases = [{'putty_file':'hackme.ppk', 'phrase':value} for value in open('dict.txt', 'r').read().split('\r\n')]
    pool = multiprocessing.Pool(processes = multiprocessing.cpu_count() + multiprocessing.cpu_count()/4)
    results = pool.map(check_putty_phrase, phrases)
    pool.close()
    pool.join()

    if any(results):
        print "phrase found '%s'!" % phrases[results.index(True)]['phrase']
    else:
        print "phrase not in dict ..."