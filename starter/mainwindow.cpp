#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QThread>
#include <QDebug>
#include <QTime>


MainWindow::MainWindow(QWidget *parent) :
	QMainWindow(parent),
	ui(new Ui::MainWindow)
{
	ui->setupUi(this);
	wsServer = new WsServer(7007);	
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
	//int index = ui->comboBox->currentIndex();
	//int correction = 5100;
	QTime time = ui->timeEdit->time();
	int offset = time.second() + time.minute()*60 + time.hour() *3600;
	qDebug() << "seek to: " << offset;
	//float seek = (bookmarks[index] - correction)/1000.0; // to seconds
	wsServer->sendToAll(QString("seek %1").arg(offset));
	//ui->seekLabel->setText(QString::number(seek));
}

void MainWindow::setClientCount(int count)
{
	ui->clientLabel->setText(QString::number(count));
}

void MainWindow::on_resetButton_clicked()
{
	ui->timeEdit->setTime(QTime(0,0,0,0));
}
