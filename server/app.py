import flask
from flask import request, jsonify
from efficientnet_pytorch import EfficientNet
import json
from PIL import Image
import torch
from torchvision import transforms

app = flask.Flask(__name__)


class Classifier:
    def __init__(self):
        self.model = EfficientNet.from_pretrained('efficientnet-b2')
        self.tfms = transforms.Compose([transforms.Resize(224), transforms.ToTensor(),
                                        transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225]), ])
        labels_map = json.load(open('labels.txt'))
        self.labels_map = [labels_map[str(i)] for i in range(1000)]

    def classify(self, img):
        self.model.eval()
        with torch.no_grad():
            img = self.tfms(Image.open(img)).unsqueeze(0)
            outputs = self.model(img)

        list_ = []
        for idx in torch.topk(outputs, k=5).indices.squeeze(0).tolist():
            prob = torch.softmax(outputs, dim=1)[0, idx].item()
            list_.append({'label': self.labels_map[idx], 'confidence': prob})
        return list_


@app.route('/run_object_inference', methods=["POST"])
def run_inference():
    try:
        if request.method == "POST":
            image_file = request.files['image']
            return jsonify({'results': classifier.classify(image_file)})
    except Exception as e:
        print(e)
        return jsonify({'results': []})


@app.route('/', methods=["GET"])
def index():
    return '''<h1>Project Vision API</h2><br>
    Send images request to <strong>/run_object_inference</strong> as POST requests to run the inference.'''


if __name__ == "__main__":
    classifier = Classifier()
    app.run()
