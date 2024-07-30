# Copy artifact demo

DIR="./scai-demo/copy-artifact/copy-artifact-metadata"


echo GENERATE COPIED ARTIFACT DESCRIPTOR
## NOTE: For some reason, -n specifies the uri instead of the name of the descriptor
scai-gen rd remote -n docker://docker.io/fengalex/python:3.12 -g sha256 -d 19973e1796237522ed1fcc1357c766770b47dc15854eafdda055b65953fe5ec1 -o $DIR/copied-artifact-desc.json "python:3.12"

echo GENERATE SOURCE ARTIFACT DESCRIPTOR
# cat <<EOF > $DIR/source-artifact-annotations.json
# {"copiedTime" : "01/23/24"}
# EOF
echo "{\"copiedTime\": \"$(date +%FT%T)\"}" > $DIR/source-artifact-annotations.json
## NOTE: For some reason, -n specifies the uri instead of the name of the descriptor
scai-gen rd remote -n docker://docker.io/library/python:3.12.2 -a $DIR/source-artifact-annotations.json -g sha256 -d 19973e1796237522ed1fcc1357c766770b47dc15854eafdda055b65953fe5ec1 -o $DIR/source-artifact-desc.json "python:3.12.2"

echo GENERATE COPY TOOL DESCRIPTOR
## NOTE: For some reason, -n specifies the uri instead of the name of the descriptor
scai-gen rd remote -n http://skopeo.com -o $DIR/copy-tool-desc.json "skopeo"

echo GENERATE "COPIED FROM" SCAI ATTRIBUTE ASSERTION
scai-gen assert -o $DIR/copied-assertion.json -e $DIR/source-artifact-desc.json "COPIED_FROM_SOURCE"

echo GENERATE SCAI REPORT FOR COPIED ARTIFACT
scai-gen report -s $DIR/copied-artifact-desc.json -o $DIR/copied-artifact.scai.json -p $DIR/copy-tool-desc.json $DIR/copied-assertion.json --pretty-print