#!/usr/bin/env python

from subprocess import Popen, PIPE

from gtp import parse_vertex, gtp_move, gtp_color
from gtp import BLACK, WHITE, PASS
import numpy as np


class GTPSubProcess(object):

    def __init__(self, label, args):
        self.label = label
        self.subprocess = Popen(args, stdin=PIPE, stdout=PIPE)
        print("{} subprocess created".format(label))

    def send(self, data):
        print("sending {}: {}".format(self.label, data))
        self.subprocess.stdin.write(data)
        result = ""
            
        while True:
            get = self.subprocess.stdout.readline()
            if not get.strip():
                break
            result += get
        print("got: {}".format(result))
        return result

    def close(self):
        print("quitting {} subprocess".format(self.label))
        self.subprocess.communicate("quit\n")


class GTPFacade(object):

    def __init__(self, label, args):
        self.label = label
        self.gtp_subprocess = GTPSubProcess(label, args)

    def name(self):
        self.gtp_subprocess.send("name\n")

    def version(self):
        self.gtp_subprocess.send("version\n")

    def boardsize(self, boardsize):
        self.gtp_subprocess.send("boardsize {}\n".format(boardsize))

    def komi(self, komi):
        self.gtp_subprocess.send("komi {}\n".format(komi))

    def clear_board(self):
        self.gtp_subprocess.send("clear_board\n")

    def genmove(self, color):
        message = self.gtp_subprocess.send(
            "genmove {}\n".format(gtp_color(color)))
        assert message[0] == "="
        return parse_vertex(message[1:].strip())

    def showboard(self):
        matrixai = np.zeros((19,19),np.int16)
        result = self.gtp_subprocess.send("showboard\n")
        seperate = result.split('\n')
        for i in range (0,19):
            county = 20-i
            for j in range (0,19):
                countx = 3+j*2
#                print seperate[county].find('X')
                if seperate[county][countx] == 'O':
                    matrixai[j][i] = 2
                elif seperate[county][countx] == 'X':
                    matrixai[j][i] = 1
#        print(matrixai)
        return matrixai

    def play(self, color, vertex):
        self.gtp_subprocess.send("play {}\n".format(gtp_move(color, vertex)))


    def final_score(self):
        result = self.gtp_subprocess.send("final_score\n")
        return result[2]

    def close(self):
        self.gtp_subprocess.close()

class play_ai(object):

#--------------kind: "black" or "white", level: "6"
    def __init__(self,kind,level):
        self.side = kind
        GNUGO = ["gnugo", "--mode", "gtp", "--level", level]
        GNUGO_MONTE_CARLO = ["gnugo", "--mode", "gtp", "--monte-carlo"]
        self.ai = GTPFacade(kind, GNUGO)
        self.ai.boardsize(19)
        self.ai.clear_board()
        self.ai.komi(5.5)
        self.first_pass = False

    def gogogo(self,play_step):
        real_step = (play_step[0]+1,play_step[1]+1)
#        print real_step
        if self.side == "black":
            if play_step == (-1,-1):
                self.ai.clear_board()
            else:
                self.ai.play(WHITE, real_step)
                self.ai.showboard()
            vertex = self.ai.genmove(BLACK)
            if vertex == PASS:
                if first_pass:
                    win = self.ai.final_score()
                    self.ai.close()
                    return (-1,-1),win
                else:
                    first_pass = True
            else:
                first_pass = False
            matrix = self.ai.showboard()

        elif self.side == "white":
            if play_step == (-1,-1):
                self.ai.clear_board()
                vertex = (0,0)
            else:
                self.ai.play(BLACK, real_step)
                self.ai.showboard()
                vertex = self.ai.genmove(WHITE)
            if vertex == PASS:
                if first_pass:
                    win = self.ai.final_score()
                    self.ai.close()
                    return (-1,-1),win
                else:
                    first_pass = True
            else:
                first_pass = False
            matrix = self.ai.showboard()

        else:
            return (-1,-1),0


        return (vertex[0]-1,vertex[1]-1), matrix
#white = GTPFacade("white", GNUGO_LEVEL_ONE)

#black.name()
#black.version()

#white.name()
#white.version()


#white.boardsize(19)

    #self.ai.komi(5.5)
#white.komi(5.5)


#white.clear_board()






