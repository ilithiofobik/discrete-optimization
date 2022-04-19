import os
import shutil

os.system("cargo build --release")
# shutil.rmtree("outputs")
# shutil.rmtree("models")
# os.mkdir("outputs")
# os.mkdir("models")

for size in range(11, 17):  # TODO: zmienić na 17
    #modelname = "models/size" + str(size) + "v1.jl"
    #rustname = "outputs/rustsize" + str(size) + "v1.txt"
    #julianame = "outputs/juliasize" + str(size) + "v1.txt"
    #cmd = "target\\release\\lab4 --size " + str(size) + " --glpk " + modelname + " > " + rustname
    # os.system(cmd)
    #cmd = "julia " + modelname + " > " + julianame
    # os.system(cmd)
    for v in range(1, 11):
        #modelname = "models/size" + str(size) + "v" + str(v) + ".jl"
        rustname = "outputs/rustsize" + str(size) + "v" + str(v) + ".txt"
        cmd = "target\\release\\lab4 --size " + str(size) + " > " + rustname
        os.system(cmd)
