#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QThread>


MainWindow::MainWindow(QWidget *parent) :
	QMainWindow(parent),
	ui(new Ui::MainWindow)
{
	ui->setupUi(this);
	wsServer = new WsServer(7007);
	ui->comboBox->insertItems(0, QStringList()<<"huomio"<<"A"<<"B"<<"B2"<< "C"<<"D"<<"D2"<<"E"<<"E2"<<"F"<< "Y"<< "G?"<< "G2"<< "H"<< "H2"<< "I"<< "I2" );
	connect(wsServer, SIGNAL(newConnection(int)), this, SLOT(setClientCount(int)) );
}

MainWindow::~MainWindow()
{
	delete ui;
}

void MainWindow::on_startButton_clicked()
{
	on_seekButton_clicked(); // send seek first
	QThread::msleep(100); // tiny wait
	wsServer->sendToAll("play");
}

void MainWindow::on_stopButton_clicked()
{
	wsServer->sendToAll("stop");
}

void MainWindow::on_seekButton_clicked()
{
	int index = ui->comboBox->currentIndex();
	int correction = 5100;
	float seek = (bookmarks[index] - correction)/1000.0; // to seconds
	wsServer->sendToAll(QString("seek %1").arg(seek));
	ui->seekLabel->setText(QString::number(seek));
}

void MainWindow::setClientCount(int count)
{
	ui->clientLabel->setText(QString::number(count));
}
